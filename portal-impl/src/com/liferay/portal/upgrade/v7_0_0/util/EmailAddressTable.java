/**
 * Copyright (c) 2000-present Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */

package com.liferay.portal.upgrade.v7_0_0.util;

import java.sql.Types;

/**
 * @author	  Brian Wing Shun Chan
 * @generated
 */
public class EmailAddressTable {

	public static final String TABLE_NAME = "EmailAddress";

	public static final Object[][] TABLE_COLUMNS = {
		{"mvccVersion", Types.BIGINT},
		{"uuid_", Types.VARCHAR},
		{"emailAddressId", Types.BIGINT},
		{"companyId", Types.BIGINT},
		{"userId", Types.BIGINT},
		{"userName", Types.VARCHAR},
		{"createDate", Types.TIMESTAMP},
		{"modifiedDate", Types.TIMESTAMP},
		{"classNameId", Types.BIGINT},
		{"classPK", Types.BIGINT},
		{"address", Types.VARCHAR},
		{"typeId", Types.BIGINT},
		{"primary_", Types.BOOLEAN}
	};

	public static final String TABLE_SQL_CREATE = "create table EmailAddress (mvccVersion LONG default 0,uuid_ VARCHAR(75) null,emailAddressId LONG not null primary key,companyId LONG,userId LONG,userName VARCHAR(75) null,createDate DATE null,modifiedDate DATE null,classNameId LONG,classPK LONG,address VARCHAR(75) null,typeId LONG,primary_ BOOLEAN)";

	public static final String TABLE_SQL_DROP = "drop table EmailAddress";

	public static final String[] TABLE_SQL_ADD_INDEXES = {
		"create index IX_2A2CB130 on EmailAddress (companyId, classNameId, classPK, primary_)",
		"create index IX_7B43CD8 on EmailAddress (userId)",
		"create index IX_F74AB912 on EmailAddress (uuid_, companyId)"
	};

}